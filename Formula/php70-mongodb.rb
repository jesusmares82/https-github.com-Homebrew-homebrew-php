require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.6.tgz"
  sha256 "cd4bb7402911431098ef6c12562dca53a89808ed1ba9798131002be1c61c6b59"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "7d864cdce2d3eec570e6a43f1108a1922c462c2af1d3e40c3cc638b20cfffc4f" => :el_capitan
    sha256 "75a1d9e11c7f4b86a81c5f60f5922c696bc6f15f0e99601b8f81ba5518002958" => :yosemite
    sha256 "beb346307c1f35adaa96b109d3a8458a5a21254a270d0029a8d43befb9368923" => :mavericks
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
