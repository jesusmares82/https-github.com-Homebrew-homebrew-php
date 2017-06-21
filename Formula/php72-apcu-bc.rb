require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72ApcuBc < AbstractPhp72Extension
  init
  desc "APC User Cache - BC"
  homepage "https://pecl.php.net/package/apcu_bc"
  url "https://pecl.php.net/get/apcu_bc-1.0.3.tgz"
  sha256 "40b63ada315ffce81e2e8d75162606090e1cc72fe94207bc7daa6dd260694919"
  head "https://github.com/krakjoe/apcu-bc.git"

  depends_on "php72-apcu"

  def install
    Dir.chdir "apcu_bc-#{version}" unless build.head?

    args = []
    args << "--enable-apc"

    safe_phpize

    # link in the apcu extension headers
    mkdir_p "ext/apcu"
    cp Dir.glob("#{Formula["php72-apcu"].opt_prefix}/include/*.h"), "ext/apcu/"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/apc.so"
    write_config_file if build.with? "config-file"
  end

  def extension
    "apc"
  end

  # This is changed so that it will be included after apcu
  def config_filename
    "ext-bc-" + extension + ".ini"
  end
end
