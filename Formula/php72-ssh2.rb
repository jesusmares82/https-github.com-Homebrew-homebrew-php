require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ssh2 < AbstractPhp72Extension
  init
  desc "Provides bindings to the functions of libssh2"
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-1.1.2.tgz"
  sha256 "87618d6a0981afe8c24b36d6b38c21a0aa0237b62e60347d0170bd86b51f79fb"
  head "https://github.com/php/pecl-networking-ssh2.git"

  bottle do
    sha256 "7e9924b10c4712501678ceba05d093fa7a23dedd925d879dcb4d2106ca02cc30" => :high_sierra
    sha256 "95db505e5b866df37bd2611a2bf6ce2c4317e92a0b185001ef41c2ebc936a255" => :sierra
    sha256 "12c179c32dd4182ac584b5cd3798a75fbd28c96f9756667afd30f1f2e7057c6d" => :el_capitan
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
