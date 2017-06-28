require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Lzf < AbstractPhp72Extension
  init
  desc "handles LZF de/compression"
  homepage "https://pecl.php.net/package/lzf"
  url "https://pecl.php.net/get/LZF-1.6.5.tgz"
  sha256 "dd116d12a3be985f42256650ce9a033fd3c4e8da4f2280c79fb9fd6a73199a4c"
  head "https://github.com/php/pecl-file_formats-lzf.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c3da66b722bff0e4f870fcaeacf384c71faacb01c669cb3e9368821e29c3fb1f" => :sierra
    sha256 "35db63bcfc3b9f680a4df4382b895d8c9f86bf157e07eda09571dc85289d9150" => :el_capitan
    sha256 "0cc6f1f10c01ca77a4488b13f31688dd541e9aab5ecbc9d7c949bb648b95befe" => :yosemite
  end

  def install
    Dir.chdir "LZF-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/lzf.so"
    write_config_file if build.with? "config-file"
  end
end
