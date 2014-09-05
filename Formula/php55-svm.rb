require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Svm < AbstractPhp55Extension
  init
  homepage 'http://php.net/manual/en/book.svm.php'
  url 'https://github.com/ianbarber/php-svm/archive/0.1.9.tar.gz'
  sha1 'e59c663f22b7bb3db53bf784e5d85e21f5719a18'
  head 'https://github.com/ianbarber/php-svm.git'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    ENV["CFLAGS"] = '-Wno-return-type'
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/svm.so"
    write_config_file if build.with? "config-file"
  end
end
