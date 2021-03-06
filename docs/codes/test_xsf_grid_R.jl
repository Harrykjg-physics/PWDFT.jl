using PWDFT

function test_fcc()
    LatVecs = gen_lattice_fcc(5.0)
    pw = PWGrid(2.0, LatVecs)
    println(pw.Ns)
    filename = "TEMP_fcc_grid_R.xsf"
    write_xsf( filename, LatVecs, pw.r )
end


function test_bcc()
    LatVecs = gen_lattice_bcc(5.0)
    pw = PWGrid(2.0, LatVecs)
    println(pw.Ns)
    filename = "TEMP_bcc_grid_R.xsf"
    write_xsf( filename, LatVecs, pw.r )
end

test_fcc()
test_bcc()