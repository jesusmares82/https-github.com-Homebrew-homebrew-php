require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Box < AbstractPhpPhar
  init
  desc "application for building and managing Phars"
  homepage "https://box-project.github.io/box2/"
  url "https://github.com/box-project/box2/releases/download/2.7.5/box-2.7.5.phar"
  sha256 "28b4b798ad4dcf8fbf9cd68aaff495d4bbeaec4363f5f319a222829d9b6abdfe"

  bottle do
    cellar :any_skip_relocation
    sha256 "cff16be7b1137d715438c4ba176fc1f3a58821c851f928fca0ae9e7ebedfa168" => :sierra
    sha256 "b1abc977036143d70f58a9fd1fc1bf603388b0ab74343dfdffe5053a980f8618" => :el_capitan
    sha256 "a2f2997cee7d4c9f84574bf1c9daa826d0b27f0f502530cf6c727b38824752da" => :yosemite
    sha256 "a56db539e2dc87a1c074d74a1fef44bf438838fdaf9e6016c13c004fd371ef7d" => :mavericks
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
    system "#{bin}/box", "--version"
  end
end
