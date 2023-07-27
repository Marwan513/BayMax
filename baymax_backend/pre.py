# -*- coding: utf-8 -*-

import scipy
import numpy as np

def low_pass_filter(voltages, window_size=100):
    """Applies a moving average low-pass filter to a 1D array of voltages."""
    # Create a windowed version of the array
    window = np.ones(window_size) / window_size
    filtered_voltages = np.convolve(voltages, window, mode='same')
    return filtered_voltages

def scale(array):
    array = np.nan_to_num(array, nan=0.0)  # Replace NaN values with 0.0
    array = low_pass_filter(array, window_size=100)

    mean = np.mean(array)
    std = np.std(array)
    if std == 0:
        # Handle the case where all elements in the array are the same
        array = np.zeros_like(array)
    else:
        array = np.array((array - mean) / std)

    a_min = np.amax(array)
    a_max = np.amin(array)
    if a_max - a_min == 0:
        # Handle the case where all elements in the normalized array are the same
        array = np.zeros_like(array)
    else:
        array = np.array((array - a_min) / (a_max - a_min))
    return array

def loadm(file_path):
    ecg=scipy.io.loadmat(file_path, struct_as_record=False)['val']
    ecg = ecg.astype(np.float32)
    for j, lead in enumerate(ecg):
        ecg[j] = scale(lead)
    ecg = np.transpose(ecg)
    ecg = ecg[np.newaxis, :]
    return ecg
