require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.5.tgz"
  sha256 "1d43c5038cd8cb7e6db57620c40f2cc6385bd538db002c60f61f44376d829848"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "f7bfa292d253b8659f12b8402fa38de6c22cb3ee4a7f5ca8bbd9f5ff038cbfdb" => :sierra
    sha256 "f8cde67d077568923fe87d9ac7982899dcac4a6346afbd13052136f8d10c0533" => :el_capitan
    sha256 "ebbc4516c16fadb0952f2e81f533c1f93b9aa1bd24694465ce37c9a692f5862e" => :yosemite
  end

  depends_on "openssl"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
