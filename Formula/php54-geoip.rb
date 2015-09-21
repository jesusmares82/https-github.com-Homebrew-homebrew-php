require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Geoip < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.0.tgz"
  sha1 "72475f10cb3549eac7d790ab6ae1869f89c6dae0"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    sha256 "e33825c727f08f63324fc2357734ef65fb196131b8b61d09be2b04a432d6379c" => :yosemite
    sha256 "3b4b1610e2a7645796883eaf92ddb7ee8c44866bb48f06a9ad4581a577e9be1d" => :mavericks
    sha256 "048cac6ed770fdb0076d91af2302857aeceaea32ac6fb2f6f223bfe7eaf439d5" => :mountain_lion
  end

  depends_on "geoip"

  def install
    Dir.chdir "geoip-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-geoip=#{Formula["geoip"].opt_prefix}"
    system "make"
    prefix.install "modules/geoip.so"
    write_config_file if build.with? "config-file"
  end
end
