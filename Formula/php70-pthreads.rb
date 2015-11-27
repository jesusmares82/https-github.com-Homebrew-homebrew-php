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
    revision 2
    sha256 "9057583b9ba0838c80b7802f4fdb3b902fc263a1eb86e459fe9da68acfde9025" => :el_capitan
    sha256 "a82c8b45bb60bda76080daaa5e6d3927540536ae94dcfc10581f5fe2efc499cb" => :yosemite
    sha256 "0860a47a006b5cc299967da42928eb18bb162321ca4444a2dc85324e1a1f2050" => :mavericks
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
