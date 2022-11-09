import torch

# a = torch.tensor([1.2, 1.3, 1.4])
# print(a.shape)

a = torch.tensor(torch.pi, dtype=torch.float64)
print("type: {}; \nvalue: {}".format(a.dtype, a))

if a.dtype != torch.float32:
    a = a.type(torch.float32)

print("type: {}; \nvalue: {}".format(a.dtype, a))
