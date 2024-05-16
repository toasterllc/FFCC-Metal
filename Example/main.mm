#import <Foundation/Foundation.h>

int main(int argc, const char* argv[]) {
    
    for (const fs::path& p : fs::directory_iterator(ImagesDirPath)) {
        if (_IsJPGFile(p)) {
            paths.push_back(p);
        }
    }
    
    return 0;
}
