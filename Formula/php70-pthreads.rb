require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pthreads < AbstractPhp70Extension
  init ["with-thread-safety"]
  desc "Threading API"
  homepage "https://pecl.php.net/package/pthreads"
  url "https://pecl.php.net/get/pthreads-3.0.8.tgz"
  sha256 "44989aa3d070969f0e1660a7cd609b2cb6c17942a6d9b5f680935df2c772df1b"
  head "https://github.com/krakjoe/pthreads.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a62b454d50ec6ad2c4855f8ccfd66bbfafe9ed47a77ee8a2af043ae16f8beda2" => :el_capitan
    sha256 "eee89b76ffe6d676f1b2eb92ca2a9664012f95edd9a0733ce85266de4c7fe59b" => :yosemite
    sha256 "c97fdc01d0ec8f1782bd8787e99d14feafbc8c2bd9b3c885eb002fda33af20ba" => :mavericks
  end

  def install
    Dir.chdir "pthreads-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/pthreads.so"
    write_config_file if build.with? "config-file"
  end
end
