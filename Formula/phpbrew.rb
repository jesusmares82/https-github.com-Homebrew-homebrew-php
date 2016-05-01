require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpbrew < AbstractPhpPhar
  init
  desc "installs multiple version php(s) in your $HOME directory"
  homepage "https://github.com/phpbrew/phpbrew"
  url "https://github.com/phpbrew/phpbrew/raw/fb208f6570969e4ca050657a3322bccd65cca6fd/phpbrew"
  version "1.21.1"
  sha256 "bbad349681684a921a4a5b24c9bb361e19d1e0d30720955d945394ced57b3570"

  bottle do
    cellar :any_skip_relocation
    sha256 "b411227e40458949dc4939d8f800164fb8cc1331bce47b86422bbe0f196c788b" => :el_capitan
    sha256 "d37f3d3b5645c520c7fa12afe3264a3ea8695d3f8f3502ecd75268e663ad6e26" => :yosemite
    sha256 "2d6e85115f902e5c7bdaa2759e053767fe5d29ffab5173f261e6160ad3cedc4b" => :mavericks
  end

  depends_on "curl"
  depends_on "gettext"
  depends_on "gmp"
  depends_on "jpeg"
  depends_on "libevent"
  depends_on "libxml2"
  depends_on "icu4c"
  depends_on "mcrypt"
  depends_on "mhash"
  depends_on "pcre"
  depends_on "re2c"

  def phar_file
    "phpbrew"
  end

  def caveats; <<-EOS.undent
    phpbrew is now installed!

    To start using it, please run
      `phpbrew init`

    You can change phpbrew home with PHPBREW_ROOT and PHPBREW_HOME env vars
    EOS
  end
end
