require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70ApcuBc < AbstractPhp70Extension
  init
  desc "APC User Cache - BC"
  homepage "https://pecl.php.net/package/apcu_bc"
  url "https://pecl.php.net/get/apcu_bc-1.0.1.tgz"
  sha256 "512674d891104d6da91811dbb89d28ab3faa356ee0ab4cbeae9bba9cf3e971cb"
  head "https://github.com/krakjoe/apcu-bc.git"

  depends_on "php70-apcu"

  def install
    Dir.chdir "apcu_bc-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-apc"

    safe_phpize

    # link in the apcu extension headers
    mkdir_p "ext/apcu"
    cp Dir.glob("#{Formula["php70-apcu"].opt_prefix}/include/*.h"), "ext/apcu/"

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

