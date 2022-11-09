import torch
from torch import nn
from torch.nn import functional
from torch import optim

import torchvision
from utils import plot_image, plot_curve, one_hot


bs = 512

# load dataset
train_data = torch.utils.data.DataLoader(
    torchvision.datasets.MNIST(
        "mnist_data",
        train=True,
        download=True,
        transform=torchvision.transforms.Compose(
            [
                torchvision.transforms.ToTensor(),
                torchvision.transforms.Normalize((0.1307,), (0.3081,)),
            ]
        ),
    ),
    batch_size=bs,
    shuffle=True,
)

test_data = torch.utils.data.DataLoader(
    torchvision.datasets.MNIST(
        "mnist_data",
        train=False,
        download=True,
        transform=torchvision.transforms.Compose(
            [
                torchvision.transforms.ToTensor(),
                torchvision.transforms.Normalize((0.1307,), (0.3081,)),
            ]
        ),
    ),
    batch_size=bs,
    shuffle=False,
)

x, y = next(iter(test_data))
print(x.shape, y.shape, x.min(), x.max())
plot_image(x, y, "image sample")


class NerualNetwork(nn.Module):
    def __init__(self) -> None:
        super(NerualNetwork, self).__init__()
        self.fc1 = nn.Linear(28 * 28, 256)
        self.fc2 = nn.Linear(256, 64)
        self.fc3 = nn.Linear(64, 10)

    def forward(self, x):
        # x:[b, 1, 28, 28]
        x = functional.relu(self.fc1(x))
        x = functional.relu(self.fc2(x))
        x = self.fc3(x)
        return x


neural_network = NerualNetwork()
optimizer = optim.SGD(neural_network.parameters(), lr=0.01, momentum=0.9)
train_loss = []

for epoch in range(3):
    for batch_idx, (x, y) in enumerate(train_data):
        x = x.view(x.size(0), 28 * 28)
        out = neural_network(x)
        y_onehot = one_hot(y)
        loss = functional.mse_loss(out, y_onehot)
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
        train_loss.append(loss.item())
        if batch_idx % 10 == 0:
            print(epoch, batch_idx, loss.item())

plot_curve(train_loss)

total_correct = 0
for x, y in test_data:
    x = x.view(x.size(0), 28 * 28)
    out = neural_network(x)
    pred = out.argmax(dim=1)
    correct = pred.eq(y).sum().float().item()
    total_correct += correct

total_num = len(test_data.dataset)
acc = total_correct / total_num
print("test acc:", acc)

x, y = next(iter(test_data))
out = neural_network(x.view(x.size(0), 28 * 28))
pred = out.argmax(dim=1)
plot_image(x, pred, "test")
