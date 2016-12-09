require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Msgpack < AbstractPhp70Extension
  init
  desc "MessagePack serialization"
  homepage "https://pecl.php.net/package/msgpack"
  url "https://pecl.php.net/get/msgpack-2.0.2.tgz"
  sha256 "b04980df250214419d9c3d9a5cb2761047ddf5effe5bc1481a19fee209041c01"
  head "https://github.com/msgpack/msgpack-php.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b203da6797526dba510146eed907dd650d0d0846b30845f2283f9a884e8a2565" => :el_capitan
    sha256 "97a0872b19badfaf85120de4e6a65737311a25822c9779bcd104a99f82e96c66" => :yosemite
    sha256 "d31728038e6c07783926f34ebfe48640bf1dd9ffc9d848c741b614e796c706a4" => :mavericks
  end

  def install
    Dir.chdir "msgpack-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/msgpack.so"
    write_config_file if build.with? "config-file"
  end
end
