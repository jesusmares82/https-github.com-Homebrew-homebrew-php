require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ev < AbstractPhp70Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.0RC2.tgz"
  sha256 "df833194c2f87d9e7d8809863b907c778dcb9323d821fd527978186bfa156e84"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
  end

  depends_on "libev"

  def install
    Dir.chdir "ev-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libev=#{Formula["libev"].opt_prefix}"
    system "make"
    prefix.install "modules/ev.so"
    write_config_file if build.with? "config-file"
  end
end
