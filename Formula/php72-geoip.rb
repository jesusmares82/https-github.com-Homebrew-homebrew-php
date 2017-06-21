require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Geoip < AbstractPhp72Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.1.tgz"
  sha256 "b2d05c03019d46135c249b5a7fa0dbd43ca5ee98aea8ed807bc7aa90ac8c0f06"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    sha256 "6480d246dadf464d323968ce79d70048157a669f831bf4b3e4ffff6e2580bfc3" => :sierra
    sha256 "318e7d1329730b38cd00452f557b141d0077ceda80a6e7bafe9e89c5f721f166" => :el_capitan
    sha256 "dd08542cb8fff8704b013459e127eec4e22168d9dc59894554baa6a5abaeeaf4" => :yosemite
  end

  depends_on "geoip"

  def install
    Dir.chdir "geoip-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-geoip=#{Formula["geoip"].opt_prefix}"
    system "make"
    prefix.install "modules/geoip.so"
    write_config_file if build.with? "config-file"
  end
end
