require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Svm < AbstractPhp56Extension
  init
  desc "Support Vector Machine Library"
  homepage "http://php.net/manual/en/book.svm.php"
  url "https://github.com/ianbarber/php-svm/archive/0.1.9.tar.gz"
  sha256 "c3dabf7220766193fcb87514559e89c1a9ec0017f510fc58cb98b3ac52819734"
  head "https://github.com/ianbarber/php-svm.git"

  depends_on "libsvm"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    ENV["CFLAGS"] = "-Wno-return-type"

    args = []
    args << "--with-svm==#{Formula["libsvm"].opt_prefix}"
    args << "--prefix=#{prefix}"
    args << phpconfig

    system "./configure", *args
    system "make"
    prefix.install "modules/svm.so"
    write_config_file if build.with? "config-file"
  end
end
