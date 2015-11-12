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
    revision 1
    sha256 "59b07a83670440260d702fda61a5f851f2cfcec80e276b8390dd38541de5a799" => :el_capitan
    sha256 "0902ea17a34d563c7e981f5f5a685cd34f93e57b601adb5d1b23cdeb642d69e4" => :yosemite
    sha256 "d22e147facf2987d5f8d3d63bb906247480e9d8299167bf2fcf14c1014818bcb" => :mavericks
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
