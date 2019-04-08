# ray_tracing_ruby

Ruby implementation of [Ray Tracing in One Weekend](https://github.com/petershirley/raytracinginoneweekend/blob/master/COPYING.txt).

## how to run it

There are no dependencies, you just need a recent-ish version of ruby (2.3+).

```
ruby main.rb > output.ppm
```

And then open `output.ppm` using your favourite image viewer.

If you are on macOS and are using iTerm, you can use imgcat to see the result right in your terminal:

```
ruby main.rb | imgcat
```

**PLEASE BE PATIENT.** Ruby is slow and this implementation is single-threaded. It took a good few minutes to render the final image at 120x80 even on an i9-9990K.
