require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Msgpack < AbstractPhp72Extension
  init
  desc "MessagePack serialization"
  homepage "https://pecl.php.net/package/msgpack"
  url "https://pecl.php.net/get/msgpack-2.0.2.tgz"
  sha256 "b04980df250214419d9c3d9a5cb2761047ddf5effe5bc1481a19fee209041c01"
  head "https://github.com/msgpack/msgpack-php.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "da463ce9047b2066ae1c7ff7a6ed0f68881353f1edecc6c2fc796e474ebeb36f" => :sierra
    sha256 "10e8e2754ba9c3ec46ed9d49f2c82c4feab5485af7cdf147e1223ee064f73532" => :el_capitan
    sha256 "954db40c159f554cdbb2cd1acb4d420cbd4e7e3c9df7be0518ac010bcc25037e" => :yosemite
  end

  def install
    Dir.chdir "msgpack-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/msgpack.so"
    write_config_file if build.with? "config-file"
  end
end
