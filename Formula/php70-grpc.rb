require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Grpc < AbstractPhp70Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.2.0.tgz"
  sha256 "df205473888ad711e6c49df51732afee3e4fbcdd8dd717497531b733b22dd4ac"

  bottle do
    cellar :any_skip_relocation
    sha256 "f694fcf41251bddbd346bd9d161df441fd66df1837629a6835aed67536396246" => :sierra
    sha256 "ca40fd9437221fa7c6fb37cd819dfc24984c381ab59ed1fbb4b5ae70132415d6" => :el_capitan
    sha256 "0f312ffaa2be5270032106c2235ad046320d24d9951da8616da251945a424eee" => :yosemite
  end

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc=#{HOMEBREW_PREFIX}",
           "--prefix=#{prefix}", phpconfig,
           "CFLAGS=-Ithird_party/boringssl/include"
    system "make"
    prefix.install "modules/grpc.so"
    write_config_file if build.with? "config-file"
  end
end
