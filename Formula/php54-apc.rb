require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Apc < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/apc"
  url "https://pecl.php.net/get/APC-3.1.13.tgz"
  sha256 "5ef8ba07729e72946e95951672a5378bed98cb5a294e79bf0f0a97ac62829abd"
  head "https://svn.php.net/repository/pecl/apc/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "f070f2f4f3bc56dc974bd9313f401261461405cff1fbb08d5aa9d7e0d07c363e" => :el_capitan
    sha256 "a21970664f88153a215ace196e7bfaf858b4dd22532c47eb1e5633f28bb59c27" => :yosemite
    sha256 "649fc60bf8a037dd9040e158465e2b884a1cd085ad13c5c6a52afb2582c8b56c" => :mavericks
  end

  depends_on "pcre"

  def install
    Dir.chdir "APC-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-apc-pthreadmutex"
    system "make"
    prefix.install %w[modules/apc.so apc.php]
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent
      apc.enabled=1
      apc.shm_segments=1
      apc.shm_size=64M
      apc.ttl=7200
      apc.user_ttl=7200
      apc.num_files_hint=1024
      apc.mmap_file_mask=/tmp/apc.XXXXXX
      apc.enable_cli=0
    EOS
  end
end
