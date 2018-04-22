from myhdl import block, always


# Provides an equality testing platform to compare values
#   In the report version, incorrect matches are reported to stdout
@block
def match_test_report(clock, a, b):
    @always(clock.negedge)
    def match_t():
        if a != b:
            print("No Match: a %s, b %s" % (bin(dver), bin(dpy)))
    return match_t


# Provides an equality testing platform to compare values
#   In the assert version, incorrect matches end execution
@block
def match_test_assert(clock, a, b):
    @always(clock.negedge)
    def match_t():
        assert(a == b)
    return match_t
