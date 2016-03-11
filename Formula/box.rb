require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Box < AbstractPhpPhar
  init
  desc "application for building and managing Phars"
  homepage "https://box-project.github.io/box2/"
  url "https://github.com/box-project/box2/releases/download/2.7.1/box-2.7.1.phar"
  sha256 "62d708f343e1a48cca8d373a4c3a7aa10379b19db19e8ba58a3125834c4d175b"

  bottle do
    cellar :any_skip_relocation
    sha256 "74922ea848058e797842b0f0ae52cbeaa91a81fb88d1369d75e1c953fef5cc70" => :el_capitan
    sha256 "3185c19d31b296eeeba1aa1399f2da462f9e8706d607cb0c9580ab8e28d8c5e8" => :yosemite
    sha256 "a8f13a129e5939af81d3d75a6de1ebfecd50466d00b60bbe26fea69585edf99a" => :mavericks
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
