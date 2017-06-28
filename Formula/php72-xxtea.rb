require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Xxtea < AbstractPhp72Extension
  init
  desc "XXTEA encryption algorithm extension for PHP."
  homepage "https://pecl.php.net/package/xxtea"
  url "https://pecl.php.net/get/xxtea-1.0.11.tgz"
  sha256 "5b1e318d3e70b27ad017d125d09ba3cf7bb3859e11be864a7bc3ddba421108af"
  head "https://github.com/xxtea/xxtea-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "71ad800c7029ed84ea262876e736b36a148b14cf073e6a3a08c717a0455863c4" => :sierra
    sha256 "496be215a4caf1f76d6557684d41e99a88a10704a93c81beaf519ff58db4e93c" => :el_capitan
    sha256 "da0699b31a7af9afaba454d3ea94a362e1b9b5c8e8fa17a4b268779b17ba4ba9" => :yosemite
  end

  def install
    Dir.chdir "xxtea-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/xxtea.so"
    write_config_file if build.with? "config-file"
  end
end
