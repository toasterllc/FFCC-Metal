# FFCC-Metal

This repo implements [Fast Fourier Color Constancy (FFCC)](https://github.com/google/ffcc) with C++ and Metal shaders. It's primarily a translation of the original MATLAB code.

This repo is used by the [Photon](https://toaster.llc/photon) camera to implement white balancing.

See [this blog post](http://toaster.llc/blog/image-pipeline) for more info.



## Performance

The average time to process a single image (with the supplied example project) is ~1.9 ms on an Apple M3 MacBook Pro.



## Example

See the `Example` directory for an example project that processes some static images.

The `_F_fft0Vals` and `_F_fft1Vals` arrays are extracted from the MATLAB code after training on a set of images for the target image sensor.