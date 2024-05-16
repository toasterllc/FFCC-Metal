#import <Foundation/Foundation.h>
#import <filesystem>
#import <MetalKit/MetalKit.h>
#import "Lib/Toastbox/Mmap.h"
#import "Lib/Toastbox/Mac/Renderer.h"
#import "FFCCModel.h"
#import <vector>
#import <chrono>
namespace fs = std::filesystem;

static bool _IsPNGFile(const fs::path& path) {
    return fs::is_regular_file(path) && path.extension() == ".png";
}

int main(int argc, const char* argv[]) {
    using namespace std::chrono;
    
    const fs::path imagesDir = fs::path(argv[0]).parent_path() / "Images";
    
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    Toastbox::Renderer renderer(device, [device newDefaultLibrary], [device newCommandQueue]);
    MTKTextureLoader* txtLoader = [[MTKTextureLoader alloc] initWithDevice:device];
    std::vector<id<MTLTexture>> txts;
    for (const fs::path& p : fs::directory_iterator(imagesDir)) @autoreleasepool {
        if (_IsPNGFile(p)) {
            id<MTLTexture> txt = [txtLoader newTextureWithContentsOfURL:[NSURL fileURLWithPath:@(p.c_str())]
                options:nil error:nil];
            txts.push_back(txt);
            
            auto illuminant = FFCCModel::Run(renderer, txt);
            printf("%s\n  illuminant: %f %f %f\n", p.c_str(), illuminant[0], illuminant[1], illuminant[2]);
        }
    }
    
    printf("\n");
    printf("Testing performance...\n");
    for (;;) {
        auto timeStart = std::chrono::steady_clock::now();
        
        constexpr int ChunkCount = 200;
        for (int i=0; i<ChunkCount; i++) @autoreleasepool {
            for (id<MTLTexture> txt : txts) {
                FFCCModel::Run(renderer, txt);
            }
        }
        
        const microseconds duration = duration_cast<microseconds>(steady_clock::now()-timeStart);
        const microseconds durationAvg = duration / (ChunkCount*txts.size());
        printf("FFCC took %ju us / image\n", (uintmax_t)durationAvg.count());
    }
    
    
    return 0;
}
