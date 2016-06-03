require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.7.tgz"
  sha256 "65bfb564d9a53a7642a02f07085bd9055b43522250649886ed65a37771cf9b49"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "961eaf7289ef3d5f08da856c72f91495995b9024eb8e46f9ebe90311727b9441" => :el_capitan
    sha256 "2453b72fa1a2e008332b7e5e668636c12558e4806aae49fcc5e4ae78ac1cf157" => :yosemite
    sha256 "1dcb6dae9daadabdc28dc145f1e21045800211edd180aef8d581c41355bcc785" => :mavericks
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
