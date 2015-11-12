require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Lzf < AbstractPhp70Extension
  init
  desc "handles LZF de/compression"
  homepage "https://pecl.php.net/package/lzf"
  url "https://pecl.php.net/get/LZF-1.6.3.tgz"
  sha256 "42ec458ea10128a801e8d39736b519ba81fa75d2a617d2777b7d6b3276601a5d"
  head "http://svn.php.net/repository/pecl/lzf/trunk/"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "eb12f21d42a5970f53dfabc17db92c49ddaaaf07162a8492e0db3d8755668a2d" => :el_capitan
    sha256 "a9abbbc70eafa900b74c93321edf0ced6731761778e2c24ea0eb9c3380775cb9" => :yosemite
    sha256 "c6a9da44609739952b64345289de96f4661444518b35361ff4000368179c33f9" => :mavericks
  end

  def install
    Dir.chdir "LZF-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/lzf.so"
    write_config_file if build.with? "config-file"
  end
end
