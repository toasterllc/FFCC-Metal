#import <Foundation/Foundation.h>
#import <Metal/Metal.h>
#import "FFCC.h"
#import "Lib/Toastbox/Mac/Renderer.h"
#import "Lib/Toastbox/Mac/Color.h"

class FFCCModel {
public:
    static Toastbox::Color<Toastbox::ColorSpace::Raw> Run(
        Toastbox::Renderer& renderer,
        id<MTLTexture> raw
    ) {
        static constexpr Toastbox::CFADesc CFADesc = {
            Toastbox::CFAColor::Green, Toastbox::CFAColor::Red,
            Toastbox::CFAColor::Blue, Toastbox::CFAColor::Green,
        };
        return FFCC::Run(_Model, renderer, CFADesc, raw);
    }
    
private:
    static const FFCC::Model _Model;
    static const uint64_t _F_fft0Vals[8192];
    static const uint64_t _F_fft1Vals[8192];
    static const uint64_t _BVals[4096];
};
