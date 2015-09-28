require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Proctitle < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/proctitle"
  url "https://pecl.php.net/get/proctitle-0.1.2.tgz"
  sha256 "b9f84b1aebbee31cee627356438def1321d1f3bcd480341501315f35f0f9e272"
  head "https://github.com/MagicalTux/proctitle.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "44781fd9183fa807456fd53182b495a549b551801b98a179e79c8b44a1b7210a" => :el_capitan
    sha256 "171abb8c92cbbfd9ff26c86ba61e171e49eefe5c7e7d21e412688543c33be5f1" => :yosemite
    sha256 "f82405f3f6e5ce197e89fb637da3c94d69834d405f1b40d8e4673f425e7cc090" => :mavericks
  end

  def install
    Dir.chdir "proctitle-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/proctitle.so]
    write_config_file if build.with? "config-file"
  end
end
