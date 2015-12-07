require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ev < AbstractPhp70Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.0RC2.tgz"
  sha256 "df833194c2f87d9e7d8809863b907c778dcb9323d821fd527978186bfa156e84"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "088d28f231f3a5e2b29765a291fecc7d96ded03adaee739da3683699b9e260ce" => :el_capitan
    sha256 "9d0b4c6d766bc0935442c912dff870d68f36ffe1ba5a9a9ae2aaf016357138d6" => :yosemite
    sha256 "0661e12e1a4ef597f020e72f4b49c987e3bda8fcb3e0cf2fdf8f043ecddca204" => :mavericks
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
