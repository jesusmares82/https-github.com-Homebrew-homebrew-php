require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ev < AbstractPhp72Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.3.tgz"
  sha256 "3c03fde9e72745e6ce6c32d680218389e0f4310908187f1529b7f227b295aeee"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b768a74a3453762dc12d3fb0b0526cab0b70f7cd1dd5f30cc5929046337d3b65" => :sierra
    sha256 "8a376ccfc0f594950bbcf6e67675d0b47c58bf7b5ef9e25e2a6c59bf20820c74" => :el_capitan
    sha256 "95a28a5507ceb0692a8d224c14e422afe33d636a6d670d4a001c703e3412c802" => :yosemite
  end

  depends_on "libev"

  def install
    Dir.chdir "ev-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libev=#{Formula["libev"].opt_prefix}"
    system "make"
    prefix.install "modules/ev.so"
    write_config_file if build.with? "config-file"
  end
end
