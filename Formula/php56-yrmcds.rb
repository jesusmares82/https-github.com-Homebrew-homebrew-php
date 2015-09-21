require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yrmcds < AbstractPhp56Extension
  init
  homepage "https://github.com/cybozu/php-yrmcds"
  url "https://github.com/cybozu/php-yrmcds/archive/v1.0.2.tar.gz"
  sha256 "5a77840db23d5b93b86c3ef9507e10894be85cd43e7283af80b6bbacd4b08b69"
  head "https://github.com/cybozu/php-yrmcds.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6258db92a70acda436caac960a5d7f735992d780fea83bc99de69d97bb4acd11" => :el_capitan
    sha256 "b728f0ce6c42472b8af2ceb780a66355cb29ab9e15725f372bdef0972f509e6e" => :yosemite
    sha256 "aa9777a9dca9954ce41184353ba416d0c0a5f99c06e3a9d95e33fae264fc6225" => :mavericks
  end

  patch do
    url "https://gist.githubusercontent.com/KonstantinKuklin/4cebe58997e2152cdc35/raw/09a5c4cd1a2739d2d9e0e38338d4e9d01058f914/patch_php-yrmcds_mac.patch"
    sha1 "a566f5eb93db4b088481a731a831bbdb4f0f3b70"
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
