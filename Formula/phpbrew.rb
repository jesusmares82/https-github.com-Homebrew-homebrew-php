require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpbrew < AbstractPhpPhar
  init
  desc "installs multiple version php(s) in your $HOME directory"
  homepage "https://github.com/phpbrew/phpbrew"
  url "https://github.com/phpbrew/phpbrew/raw/56300713fe9f99084a52987d624579d92c2b1844/phpbrew"
  version "1.22.5"
  sha256 "84301c766146bdc04f10e8cb0e8c2aefeaf943b0bea24ca42318a8f12c0aee1b"

  bottle do
    cellar :any_skip_relocation
    sha256 "0f7907c4a61d64c8857883201d8fceabedf479a8c80c3d835fcbdea2e1d139cf" => :sierra
    sha256 "8fc74c72f3218a71955e2a6278eb65e192d48dff3ec6f4205b660cf69a118f03" => :el_capitan
    sha256 "f910fd3fa490c55b11ad83e72f0334861fbe16439a58106b33301a405d3f7efe" => :yosemite
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
