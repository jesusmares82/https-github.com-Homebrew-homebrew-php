require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Proctitle < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/proctitle"
  url "https://pecl.php.net/get/proctitle-0.1.2.tgz"
  sha256 "b9f84b1aebbee31cee627356438def1321d1f3bcd480341501315f35f0f9e272"
  head "https://github.com/MagicalTux/proctitle.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "73dd778d6f482bc405865d52ec63b44f403cb4b7eda567663ef96d050e71f577" => :el_capitan
    sha256 "ef4979f8b3854fa5af14dc0f06a50120e6aaeb1178b78cb7e178eacb60f02473" => :yosemite
    sha256 "2fa06ef7c3393866b529273fc856e66e497678d71f4e998a832a7d5a3f5b4a7f" => :mavericks
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
