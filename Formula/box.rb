require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Box < AbstractPhpPhar
  init
  desc "application for building and managing Phars"
  homepage "https://box-project.github.io/box2/"
  url "https://github.com/box-project/box2/releases/download/2.7.2/box-2.7.2.phar"
  sha256 "a8228cfd115691a3a1608450989ccbadc9cd94f931917a8b9ff17d25a10a76e9"

  bottle do
    cellar :any_skip_relocation
    sha256 "13cea0eb0d77d43de1351d2f6a790145763c7ff779d795406a286b77a9bb9d94" => :el_capitan
    sha256 "5569b7d89ec9f0f0fc24e0fe40e8d13ca985c132f48bde97c6f21677eba6bcbc" => :yosemite
    sha256 "e3960104cbe1825f1e8365a933e022be309cec186e5cbe1856ed44ff9c25781e" => :mavericks
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
