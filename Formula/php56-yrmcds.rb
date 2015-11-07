require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yrmcds < AbstractPhp56Extension
  init
  desc "Memcached/yrmcds client extension for PHP5"
  homepage "https://github.com/cybozu/php-yrmcds"
  url "https://github.com/cybozu/php-yrmcds/archive/v1.0.4.tar.gz"
  sha256 "b509631c57d60d9003954164756448454f8a09e789dc67ce531363c6c08bc273"
  head "https://github.com/cybozu/php-yrmcds.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6258db92a70acda436caac960a5d7f735992d780fea83bc99de69d97bb4acd11" => :el_capitan
    sha256 "b728f0ce6c42472b8af2ceb780a66355cb29ab9e15725f372bdef0972f509e6e" => :yosemite
    sha256 "aa9777a9dca9954ce41184353ba416d0c0a5f99c06e3a9d95e33fae264fc6225" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/yrmcds.so"
    write_config_file if build.with? "config-file"
  end
end
