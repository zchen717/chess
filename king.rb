class King < Stepper
  def moves_array
    DIAG + STRT
  end
end