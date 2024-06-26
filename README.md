# FFCC-Metal

This repo implements illuminant estimation via [Fast Fourier Color Constancy (FFCC)](https://github.com/google/ffcc) with C++ and Metal shaders. It's primarily a translation of the original MATLAB code to Metal.

This code is used by [Photon](https://toaster.llc/photon)'s image pipeline to implement highlight reconstruction and white balancing.

See [this blog post](http://toaster.llc/blog/image-pipeline) for more info about Photon's image pipeline.



## Performance

The average time to process a single image (with the included example project) is ~1.9 ms on an Apple M3 MacBook Pro.

The performance could be improved further but effort hasn't been invested to do so because the existing performance is fine for Photon's needs.



## Example

See the `Example` directory for an example project that runs FFCC on some static images.

The `FFCCModel::_F_fft0Vals` and `FFCCModel::_F_fft1Vals` arrays are extracted from the MATLAB code after training on a set of images for the target image sensor.
