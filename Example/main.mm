#import <Foundation/Foundation.h>
#import <filesystem>
#import "Lib/Toastbox/Mmap.h"
#import "Lib/Toastbox/Mac/Renderer.h"
#import "FFCCModel.h"
namespace fs = std::filesystem;

static bool _IsCFAFile(const fs::path& path) {
    return fs::is_regular_file(path) && path.extension() == ".cfa";
}


int main(int argc, const char* argv[]) {
    
    
//    const fs::path dirPath = fs::path(argv[0]).parent_path();
//    const fs::path imagesPath = dirPath / "Images";
//    for (const fs::path& p : fs::directory_iterator(dirPath / "Images")) {
//        
//    }
    
    id <MTLDevice> device = MTLCreateSystemDefaultDevice();
    Toastbox::Renderer renderer(device, [device newDefaultLibrary], [device newCommandQueue]);
    for (const fs::path& p : fs::directory_iterator("/Users/dave/repos/FFCC-Metal/Example/Images")) {
        if (_IsCFAFile(p)) {
            const Toastbox::Mmap mmap(p);
            const uint16_t* rawImageData = (uint16_t*)(mmap.data()+32);
            constexpr size_t ThumbWidth = 576;
            constexpr size_t ThumbHeight = 324;
            const size_t rawImageDataLen = ThumbWidth * ThumbHeight * 2; // 373248 bytes
            Toastbox::Renderer::Txt txt = renderer.textureCreate(MTLPixelFormatR16Float, ThumbWidth, ThumbHeight);
            
            printf("path: %s\n", p.c_str());
            
            auto illuminant = FFCCModel::Run(renderer, txt);
            printf("illuminant: %f %f %f\n", illuminant[0], illuminant[1], illuminant[2]);
            
            renderer.textureWrite(txt, rawImageData, 1);
            renderer.commitAndWait();
            renderer.debugTextureShow(txt);
            exit(0);
//            576 * 324 = 186624 pixels * 2 = 373248 bytes
            
//            printf("%s\n", p.string().c_str());
        }
    }
    
    return 0;
}
