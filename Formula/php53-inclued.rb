require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Inclued < AbstractPhp53Extension
  init
  homepage 'https://pecl.php.net/package/inclued'
  url 'https://pecl.php.net/get/inclued-0.1.3.tgz'
  sha256 '89d7324b164b739b53d5290c7ec99d8e05522e76db0885bda4b4a693113b4a28'
  head 'https://svn.php.net/repository/pecl/inclued/trunk'

  def install
    Dir.chdir "inclued-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/inclued.so"
    write_config_file if build.with? "config-file"
  end
end
