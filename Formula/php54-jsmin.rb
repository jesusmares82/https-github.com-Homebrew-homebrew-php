require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Jsmin < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/jsmin"
  url "https://pecl.php.net/get/jsmin-1.1.0.tgz"
  sha256 "9cf4180a816bac08300c45083410ca536200bd4940db0174026b9a825161f159"
  head "https://github.com/sqmk/pecl-jsmin.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "a3c253697d16fab10fc702afccaa9a579e7ac69dbd1cc738fff32dedb1086075" => :el_capitan
    sha256 "0c69edac3d6ba58eacb991e1c7cf70c1835aef26c265ddc9392f8188560d35af" => :yosemite
    sha256 "06c78e6fdf50557182c0417fa5e13eae61d089bb760c85c4560fe3cab2f45c19" => :mavericks
  end

  def install
    Dir.chdir "jsmin-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/jsmin.so"
    write_config_file if build.with? "config-file"
  end
end
