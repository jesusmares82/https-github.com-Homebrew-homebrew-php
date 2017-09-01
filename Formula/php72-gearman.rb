require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gearman < AbstractPhp72Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://github.com/wcgallego/pecl-gearman"
  url "https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.3.tar.gz"
  sha256 "f71e8ff218f31e3b9a15534e18846b9f9526319daffcc12e76b545889e44e130"
  head "https://github.com/wcgallego/pecl-gearman.git"
  revision 1

  bottle do
    sha256 "6ba75c0f79091c89dcc08ced2f727683de005216fa84cd74c1faa055f34a4d5c" => :sierra
    sha256 "9569b4894b3d00f163d81a0579b6e728c67686c107efb090af145869f8898901" => :el_capitan
    sha256 "d3bd19442e0cdc220199e36a2c38cc38e5fbde86c055cdca8c650ca6e3f48f28" => :yosemite
  end

  depends_on "gearman"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-gearman=#{Formula["gearman"].opt_prefix}"

    system "make"
    prefix.install "modules/gearman.so"
    write_config_file if build.with? "config-file"
  end
end
