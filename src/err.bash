# @depends std_out
std_err()
{
    std_out ${@} 1>&2
}
