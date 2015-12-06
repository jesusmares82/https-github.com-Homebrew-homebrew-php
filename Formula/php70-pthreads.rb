require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pthreads < AbstractPhp70Extension
  init ["with-thread-safety"]
  desc "Threading API"
  homepage "https://pecl.php.net/package/pthreads"
  url "https://pecl.php.net/get/pthreads-3.1.5.tgz"
  sha256 "e59a4e02b0eaff08d9522bf8b491f47187ce0dfe96709a243e2cffe12fb82afe"
  head "https://github.com/krakjoe/pthreads.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c300759ad03dc7f4bfe7ba02f72e03a0b46703c4cb649838678c79be4d48fb81" => :el_capitan
    sha256 "045079bb15949903de35067b9395986977f86ece0511615fa4b79e4cd9ba6aec" => :yosemite
    sha256 "5c707ef6404e0ca02667fb61ebb4a0f1e33d6943bdc5949e5c31bd72a797476f" => :mavericks
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
