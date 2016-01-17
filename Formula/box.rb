require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Box < AbstractPhpPhar
  init
  desc "application for building and managing Phars"
  homepage "https://box-project.github.io/box2/"
  url "https://github.com/box-project/box2/releases/download/2.7.0/box-2.7.0.phar"
  sha256 "f7bd7ac6c6cd6d3ba0d87dc81ac9d1b6e8c9aa8a2a87a026bd182ec18edafc7e"

  bottle do
    cellar :any_skip_relocation
    sha256 "fe91af7752c0e69cce243f0e1ee7c552872e33f8efc3320750becd8974ee56e0" => :el_capitan
    sha256 "16fe74c0b7d171434904aa3ce83fa0d6b7f2ce1d62482f71004452b432c07572" => :yosemite
    sha256 "74f3c77e1e3dcd6644e7274d237f842c758950ece546366b0645c4de9d6539e7" => :mavericks
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
