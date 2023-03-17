def bench(repetitions = 100, &block)
  require "benchmark"

  Benchmark.bmbm do |b|
    b.report { repetitions.times(&block) }
  end
  nil
end

def benchtime(times = 1)
  require "benchmark"
  ret = nil
  Benchmark.bm { |x| x.report { times.times { ret = yield } } }
  ret
end
