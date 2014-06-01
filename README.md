# JsonResume

JsonResume helps in creating different versions of resume from a single JSON input file. It is different from present solutions as the output is more prettier and much customized to modern resume templates. Also, there is a ton of customization to the templates possible, to make your own version of resume created super quickly.

## Installation

    $ gem install json_resume

## Usage

### Create a sample JSON input file to start

    $ json_resume sample
    
A sample `prateek_cv.json` will be generated in the current working directory(cwd).
    
Modify it as per your needs, and remove or keep rest of the fields empty.
    
### Conversion

* Default (HTML) version

```
    $ json_resume convert prateek_cv.json
```

A directory `resume/` will be generated in cwd, which can be put hosted on /var/www or on github pages.

* PDF version from HTML

```
    $ json_resume convert --out=html_pdf prateek_cv.json
```

* LaTeX version

```
    $ json_resume convert --out=tex prateek_cv.json
```

* PDF version from LaTeX

```
    $ json_resume convert --out=tex_pdf prateek_cv.json
```

* Markdown version

```
    $ json_resume convert --out=md prateek_cv.json
```

## Customization

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
