require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ssh2 < AbstractPhp72Extension
  init
  desc "Provides bindings to the functions of libssh2"
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-1.0.tgz"
  sha256 "6a93891878b23904a773eb814fec7aea4ea00b4a412ee779c8535ed9c5e46ced"
  head "https://github.com/php/pecl-networking-ssh2.git"

  bottle do
    sha256 "8514e7509c3bcab7ac223df1f063cb4cdc2257b340aa10244075c8545b166cb0" => :sierra
    sha256 "0a1604f3d71e49da3d15b83a13589231e15acf3c1deace262d770fb2b8132b4e" => :el_capitan
    sha256 "6a2c4b1fcc65997e4a4aae406614d61abe582072483b328b942b5bfbd2c1c8af" => :yosemite
  end

  depends_on "libssh2"

  def install
    Dir.chdir "ssh2-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-ssh2=#{Formula["libssh2"].opt_prefix}"
    system "make"
    prefix.install "modules/ssh2.so"
    write_config_file if build.with? "config-file"
  end
end
