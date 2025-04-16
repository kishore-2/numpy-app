import numpy as np

def test_sum():
    result = np.array([1, 2]) + np.array([3, 4])
    expected = np.array([4, 6])
    assert np.array_equal(result, expected), f"Expected {expected}, but got {result}"
    print("test_sum passed!")

if __name__ == "__main__":
    test_sum()
