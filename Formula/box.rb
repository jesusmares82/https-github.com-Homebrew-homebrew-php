require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Box < AbstractPhpPhar
  init
  desc "application for building and managing Phars"
  homepage "https://box-project.github.io/box2/"
  url "https://github.com/box-project/box2/releases/download/2.7.1/box-2.7.1.phar"
  sha256 "62d708f343e1a48cca8d373a4c3a7aa10379b19db19e8ba58a3125834c4d175b"

  bottle do
    cellar :any_skip_relocation
    sha256 "d5ce90623297ea68f87a3fd14fccd38a0b09ebf0c27a12e6f9e8177ea6016429" => :el_capitan
    sha256 "35a5452f6c4479e6a6369f1da78e7513180ea6a7362d8e06583fc3652d3842a9" => :yosemite
    sha256 "055fdb534cb834dc46e9b8dc311c0e22068d7791a71102fd669e95f7b02e310e" => :mavericks
  end

  def phar_file
    "box-#{version}.phar"
  end

  def phar_wrapper
    <<-EOS.undent
      #!/usr/bin/env bash
      set -- $* && [ "${0##*/} $1" == "box build" ] && PHARRW="-d phar.readonly=Off"
      /usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off $PHARRW #{libexec}/#{@real_phar_file} $*
    EOS
  end

  test do
    system "box", "--version"
  end
end
